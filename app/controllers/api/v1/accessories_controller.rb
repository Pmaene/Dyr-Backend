class Api::V1::AccessoriesController < Api::V1::BaseController
    def index
        plural_resource_name = "@#{resource_name.pluralize}"
        resources = resource_class.where(query_params).all.to_a
        instance_variable_set plural_resource_name, resources

        unless current_resource_owner.nil?
            resources.delete_if do |resource|
                not current_resource_owner.admin? and not resource.users.include? current_resource_owner
            end

            unless current_resource_owner.admin?
                respond_with resources, only: [:id, :name, :description, :events] and return
            end
        end

        respond_with resources
    end
end
