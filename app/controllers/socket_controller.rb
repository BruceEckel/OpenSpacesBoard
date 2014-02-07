class SocketController < WebsocketRails::BaseController

	# Triggered when a new topic is added by a user
	# This broadcasts the event out to all connected clients
	# which trigger JS updates of the board display
	def new_topic
		# Get the topic that was just added by the space time ID of the 
		# space time block from the board
		topic = Topic.find_by space_time_id: message[:space_time_id]
		broadcast_message :new_topic, {
			id: message[:space_time_id],
			title: topic.title,
			desc: topic.description,
			author: find_user_name_by_id(topic.user_id)
		}
	end

	# Triggered when a user clicks to create a new topic
	# This will lock the spacetime so no other user can interact with it
	def lock_spacetime
		broadcast_message :lock_spacetime, {
			id: message[:space_time_id]
		}
	end

	# Triggered when a user is done interacting with a spacetime
	# This will unlock the spacetime so users may interact with it again
	def unlock_spacetime
		broadcast_message :unlock_spacetime, {
			id: message[:space_time_id]
		}
	end

end