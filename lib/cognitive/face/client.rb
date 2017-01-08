module Cognitive
  module Face

    class Client
      # Constructor
      #
      # @param key [String] Subscription key which provides access to this API

      def initialize(key:)
        @key = key
        @headers = {
          'Ocp-Apim-Subscription-Key' => @key,
          'Content-Type': 'application/json'
        }
        @endpoints = {
          detect:'https://api.projectoxford.ai/face/v1.0/detect',
          facelist: 'https://api.projectoxford.ai/face/v1.0/facelists/',
          findsimilar: 'https://api.projectoxford.ai/face/v1.0/findsimilars'
        }
      end

      # Detect human faces in an image and returns face locations, and optionally with faceIds, landmarks, and attributes
      # Api rest documentation https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236
      #
      # @param face [File] JPEG, PNG, GIF
      # @param return_face_id [Boolean] return face id or not. default true 

      def detect(face:,return_face_id: true,
                returnFaceLandmarks:false, 
                returnFaceAttributes: nil)
        query_params = {
          returnFaceId: return_face_id,
          returnFaceLandmarks: returnFaceLandmarks
        }

        headers = @headers.merge(
          params: query_params,
          'Content-Type': 'application/octet-stream'
        )

       client = RestClient.post(
        @endpoints[:detect],
        face,
        headers
       )
       Response.new(client).get
      end

      # Get information a face list id
      # Api rest documentation https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f3039524c
      # @param face_list_id [String]

      def get_face_list(face_list_id:)
        client = RestClient.get(
          @endpoints[:facelist] + face_list_id.to_s,
          @headers
        )
        Response.new(client).get
      end

      # Delete face list
      # @param face_list_id[String]
      # Api rest documentation https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f3039524f
      
      def delete_face_list(face_list_id:)
        client = RestClient.delete(
          @endpoints[:facelist] + face_list_id.to_s,
          @headers
        )
        Response.new(
          client,
          json: false,
          response_custom: lambda {|client| client.code == 200}
        ).get
      end


      # Get all face lists
      # Api rest documentation https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f3039524c

      def get_face_lists
        client = RestClient.get(
          @endpoints[:facelist],
          @headers
        )
        Response.new(client).get
      end

      # Create face list
      # @param face_list_id[String] unique indentify
      # @param name[String] name face list
      # @param user_data[String] Optinal info

      def create_face_list(face_list_id:,name:,user_data: nil)
        params = {
          name: name,
          userData: user_data
        }.to_json
        client = RestClient.put(
          @endpoints[:facelist]+face_list_id.to_s,
          params,
          @headers
        )
         Response.new(
          client,
          json: false,
          response_custom: lambda {|client| client.code == 200}
          ).get
      end

      # Add face to face list
      # @param face[File] Image
      # @param face_list_id[String]
      # @param user_data[String] Optinal
      # @param target_face Optional
      def add_face_to_face_list(face:, face_list_id:, user_data: nil, target_face: nil)
        headers = @headers.merge(
          params: {
            userData: user_data,
            targetFace: target_face
          },
          'Content-Type': 'application/octet-stream'
        )
        client = RestClient.post(
          @endpoints[:facelist]+"#{face_list_id}/persistedFaces",
          face,
          headers
        )
        Response.new(client).get
      end

      # Deleted face from a face list
      # @param face_id[String]
      # @param face_list_id[String]

      def delete_face_to_face_list(face_id:, face_list_id:)
        client = RestClient.delete(
          @endpoints[:facelist]+"#{face_list_id}/persistedFaces/#{face_id}",
          @headers
        )
        Response.new(
          client,
          json: false,
          response_custom: lambda {|client| client.code == 200}
        ).get
      end

      # Find face from  a face list
      # @param face_id[String]
      # @param face_list_id[String]
      # @param mode[String] 

      def find_similar(face_id:, face_list_id:, mode: 'matchPerson')
        data = {
          faceId: face_id,
          faceListId: face_list_id,
          mode: mode
        }
        client = RestClient.post(
          @endpoints[:findsimilar],
          data.to_json,
          @headers
        )
        Response.new(client).get
      end
    
    end


  end
end