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
  id 1726
  arrival_time 38537.28507465385
  lifetime 729.3542558468723
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 39
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 24
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 27
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 34
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
]
