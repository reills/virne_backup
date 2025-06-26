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
  id 1307
  arrival_time 27311.941209069537
  lifetime 3843.031331811725
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 43
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 16
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 44
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 22
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 22
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 44
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 4
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
]
