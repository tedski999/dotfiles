function septs --argument name --description "Login to septs home server via SSH connection"
	if set -q name[1]
		ssh $name@tjsj.dev
	else
		ssh tjsj.dev
	end
end
