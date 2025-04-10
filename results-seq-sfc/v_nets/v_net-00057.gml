graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 57
  arrival_time 1172.993782650757
  lifetime 295.3558152819613
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 41
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 34
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
]
