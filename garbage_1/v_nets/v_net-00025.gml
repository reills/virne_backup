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
  id 25
  arrival_time 554.8919971130648
  lifetime 3163.0240253998286
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 21
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 45
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 19
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 3
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 33
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 48
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 15
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 44
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 18
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 24
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
]
