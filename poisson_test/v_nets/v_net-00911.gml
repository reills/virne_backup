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
  id 911
  arrival_time 19435.603138222807
  lifetime 1213.0047430924164
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 34
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 32
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 25
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 2
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 40
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 0
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 9
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
]
