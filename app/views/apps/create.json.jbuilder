if @error.nil?
    json.array! @response
else
    json.error @error
end