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
  id 512
  arrival_time 9776.892326538904
  lifetime 517.6780683558914
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 22
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 48
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
]
