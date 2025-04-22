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
  id 550
  arrival_time 10370.192228647446
  lifetime 416.79582998682696
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 11
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 43
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 23
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 34
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 16
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 49
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
]
