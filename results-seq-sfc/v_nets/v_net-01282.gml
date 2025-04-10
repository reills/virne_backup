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
  id 1282
  arrival_time 26762.141353569124
  lifetime 1844.8710086927615
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 24
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 30
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 24
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 13
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 39
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 38
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 5
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
]
