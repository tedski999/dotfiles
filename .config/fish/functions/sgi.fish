function sgi --argument reponame
	if set -q reponame[1]
		ssh git@tjsj.dev "git init --bare /srv/git/$reponame.git"
	else
		echo "sgi needs a repository name to create!" 1>&2
	end
end
