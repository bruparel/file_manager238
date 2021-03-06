# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # def get_main_navigation
  #   if is_admin?
  #     x = navigation [:clients, :folders, :documents, {:notes => {:controller => 'client_comments', :action => 'index'}},
  #                     :users, {:client_perms => {:controller => 'clients', :action => 'list_perms'}},
  #                             {:folder_perms => {:conroller => 'folders', :action => 'list_perms'}}, 
  #                     {:admin => {:controller => 'admin', :action => 'instruct'}}]
  #   elsif is_leader? || is_staff?         # can view all clients and folders but no admin stuff
  #     x = navigation [:clients, :folders, :documents, {:notes => {:controller => 'client_comments', :action => 'index'}}]
  #   elsif is_eclient?                   # meaning a user representing an external client
  #     x = navigation [{:welcome => root_path},{:basic_info => {:controller => 'clients', :action => 'edit'}}, :folders,
  #                      :documents, {:notes => {:controller => 'client_comments', :action => 'index'}}]
  #   else                             # not logged in, show barebones menu
  #     x = navigation [{:welcome => root_path}]
  #   end
  #   x
  # end

  def sub_navigation
    navigation controller_name.downcase.to_sym, :class => 'sub_navigation'
  rescue RPH::Navigation::InvalidMenuIdentifier
    nil
  end

  def search_checked?(which_action)
    return true if which_action.blank?
    return true if which_action == "Search"
    false
  end

  def filter_checked?(which_action)
    return false if which_action.blank?
    return true if which_action == "Filter"
    false
  end

  def get_filter_by_value(ary, filter_id)
    ary.each do |a|
      return a if a[1] == filter_id
    end
    ""
  end

  def folder_checked?(which_action)
    return false if which_action.blank?
    return true if which_action == "Folder"
    false
  end

  def get_folder_value(ary, folder_id)
    ary.each do |a|
      return a if a[1] == folder_id
    end
    ""
  end

  def h_link_to(link_str, rel_path)
    if logged_in? && current_user.help_on
      link_to(link_str,{},{:class => "tip", :title =>link_str, :rel => rel_path})
    else
      link_str
    end
  end

  def show_document_edit_delete_links(doc_record)
    return false if is_staff?
    return false if is_eclient? && (!doc_record.folder.eclient_flag)
    true
  end

  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      # modified Bort code to fit WAT requirements - Bharat
      messages << content_tag(:div, content_tag(:p, html_escape(flash[msg.to_sym])), :class => "message #{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
  safe_helper :flash_messages

  def labeled_form_for(*args, &block)
    options = args.extract_options!.merge(:builder => LabeledFormBuilder)
    form_for(*(args + [options]), &block)
  end

  def render_error_messages(*objects)
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    render :partial => 'error_messages', :object => messages unless messages.empty?
  end

  def render_crud_table(obj,controller_name,columns,search_fields_array,status_array,actions)
    render :partial => 'shared/crud_maint_table', :object => obj,
     :locals => {:controller_name => controller_name, :columns => columns, :search_fields_array => search_fields_array, :status_array => status_array, :actions => actions}
  end
end
