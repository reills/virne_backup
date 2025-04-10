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
  id 215
  arrival_time 3889.7911852659695
  lifetime 802.5274955543603
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 50
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 7
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
]
