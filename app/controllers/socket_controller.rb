class SocketController < WebsocketRails::BaseController

	def new_topic
		topic = Topic.find_by space_time_id: message[:space_time_id]
		broadcast_message :new_topic, {
			id: message[:space_time_id],
			title: topic.title,
			desc: topic.description,
			author: find_user_name_by_id(topic.user_id)
		}
	end

end