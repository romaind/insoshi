@asset = Asset.find(ARGV[0])

if @asset
  @asset.convert
end