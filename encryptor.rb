class Encryptor

  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def reverse_rotation(rotation)
    rotation * -1
  end

  def encrypt(string, rotation)
    letters = string.split("")

    results = letters.collect do |letter|
      encrypt_letter(letter, rotation)
    end

    results.join
  end

  def decrypt(string, rotation)
    encrypted_letters = string.split("")

    results = encrypted_letters.collect do |letter|
      encrypt_letter(letter, reverse_rotation(rotation))
    end

    results.join
  end

  def encrypt_file(filename, rotation)
    # create the file handle to input the file
    file = File.open(filename, 'r')
    # read the text of the input file
    text = file.read
    file.close
    # encrypt the text
    encrypted_text = encrypt(text, rotation)
    # create a name for the input file
    encrypted_filename = "#{filename}_encrypted"
    # create an output file
    encrypted_file = File.open(encrypted_filename, "w")
    # write out the text
    encrypted_file.write(encrypted_text)
    # close the file
    encrypted_file.close
  end

  def decrypt_file(filename, rotation)
    # create the file handle to input the file
    file = File.open(filename, 'r')
    # read the text of the input file
    text = file.read
    file.close
    # encrypt the text
    decrypted_text = decrypt(text, rotation)
    # create a name for the input file
    decrypted_filename = "#{filename.gsub('encrypted', 'decrypted')}"
    # create an output file
    decrypted_file = File.open(decrypted_filename, "w")
    # write out the text
    decrypted_file.write(decrypted_text)
    # close the file
    decrypted_file.close
  end

  def supported_characters
    (' '..'z').to_a
  end

  def crack(message)
    results = supported_characters.count.times.collect do |attempt|
      decrypt(message, attempt)
    end

    file = File.open("cracked.txt", "w")
    results.each do |result|
      file.write("#{result} \n")
    end

    file.close
  end

end