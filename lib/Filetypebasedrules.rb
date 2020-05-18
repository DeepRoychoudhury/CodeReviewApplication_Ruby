require_relative '../../lib/uploadLibrary/lib/zip'
class BaseRule
	def initialize(parameters)

	end
end

class AdditionalRule
	def initialize()
	end
end

class AnalyzecontrollerRule < AdditionalRule
	def initialize()

	end

	def findcontrollerpaths
		@user=User.find(params[:id])
		@project = Project.find(params[:id])
      	@myPath = @project.Path
      	Zip::File.open(@myPath) do |zip_file|
      		Zip.on_exists_proc = true
      		zip_file.each do |entry|      			
            	puts "Extracting #{entry.name}"
      		end
      	end
	end
end

class AnalyzemodelRule < AdditionalRule
	def initialize()
	end
end

class AnalyzeviewRule < AdditionalRule
	def initialize()
	end
end