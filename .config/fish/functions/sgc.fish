function sgc --argument reponame
	if set -q reponame[1]
		git clone tedski999@tjsj.dev:/srv/git/$reponame.git
	else
		echo "sgc needs a repository name to clone from!" 1>&2
	end
end
