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
  id 572
  arrival_time 10746.047387923005
  lifetime 787.5928477248533
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 39
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 35
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 0
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 22
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 14
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
]
