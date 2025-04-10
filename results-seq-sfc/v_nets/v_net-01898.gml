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
  id 1898
  arrival_time 41914.44320885326
  lifetime 354.80201523861297
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 29
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 21
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 23
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 47
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 19
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
]
