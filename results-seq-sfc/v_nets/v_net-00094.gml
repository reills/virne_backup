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
  id 94
  arrival_time 1927.0467509822324
  lifetime 606.0054080763949
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 17
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 21
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 33
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 47
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 25
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 43
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 22
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 33
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 20
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 43
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 39
    gpu 40
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
]
