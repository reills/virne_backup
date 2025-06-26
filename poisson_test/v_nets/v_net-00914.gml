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
  id 914
  arrival_time 19627.836598682865
  lifetime 2434.731242510214
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 7
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 27
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 4
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 15
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 32
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
]
