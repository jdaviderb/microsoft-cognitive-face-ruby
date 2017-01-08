require "spec_helper"

describe Cognitive::Face::Client do
  
  subject(:face_client) {
    Cognitive::Face::Client.new(
      key: ENV['MICROSOFT_FACE_KEY']
    )
  }

  before(:all) do 
    @face_list_id = SecureRandom.uuid
  end

  it "should build face detect" do
    client = face_client.detect(face: File.read('examples/dhh.jpg'))
    expect(client.class).to eq(Array)
    face = client[0]
    expect(face.respond_to?(:faceId)).to eq(true)
  end

  it 'should build face list' do 

    client =  face_client.create_face_list(
      face_list_id: @face_list_id,
      name: @face_list_id
    )

    expect(client).to be true
  
  end

  it 'should add face a to  face list' do
    client = face_client.add_face_to_face_list(
      face: File.read('examples/dhh.jpg'),
      face_list_id: @face_list_id
    )
    expect(client.respond_to?(:persistedFaceId)).to be true
  end

  it 'should show a face list' do 
    client = face_client.get_face_list(
      face_list_id: @face_list_id
    )
    expect(client.respond_to?(:faceListId)).to eq(true)
  end

  it 'should show all face list' do 
    client = face_client.get_face_lists
    expect(client.class).to eq(Array)
  end

  it 'should delete a face of face list' do 
    face = face_client.add_face_to_face_list(
      face: File.read('examples/dhh.jpg'),
      face_list_id: @face_list_id
    )

    face_remove = face_client.delete_face_to_face_list(
      face_id: face.persistedFaceId,
      face_list_id: @face_list_id
    )

    expect(face_remove).to be true
  end

  it 'should find similar face a face list' do 
    face = face_client.detect(face: File.read('examples/dhh.jpg'))
    client = face_client.find_similar(
      face_list_id: @face_list_id,
      face_id: face[0].faceId
    )
    expect(client.class).to eq(Array)
  end

  it 'should delete a face list' do 
    expect(face_client.delete_face_list(face_list_id: @face_list_id)).to eq true
  end

end


