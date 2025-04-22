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
  id 1417
  arrival_time 29658.67982729674
  lifetime 441.61554342364144
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 2
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 3
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 30
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 11
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 46
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 5
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 17
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 11
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 38
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 36
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 4
    rom 25
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 27
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 9
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
]
