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
  id 244
  arrival_time 4542.242317306674
  lifetime 1273.4790625470728
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 10
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 22
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 46
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 23
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 3
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 33
    rom 20
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 48
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 0
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 39
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 36
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 15
    rom 48
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 8
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
]
