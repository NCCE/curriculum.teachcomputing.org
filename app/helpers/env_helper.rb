module EnvHelper
  def envVarToBool?(envVar)
    ActiveRecord::Type::Boolean.new.cast(ENV[envVar])
  end
end
