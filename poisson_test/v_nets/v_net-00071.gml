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
  id 71
  arrival_time 1304.9375807217516
  lifetime 2424.872006992466
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 4
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 5
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 41
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 10
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
]
