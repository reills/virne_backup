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
  id 830
  arrival_time 17131.351100903055
  lifetime 1140.2721073426435
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 5
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 19
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 14
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 4
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 48
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 50
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 18
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 30
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 36
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 38
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 11
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 43
    rom 10
  ]
  node [
    id 12
    label "12"
    cpu 48
    gpu 27
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 15
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
]
