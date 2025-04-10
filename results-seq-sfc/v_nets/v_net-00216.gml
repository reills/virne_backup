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
  id 216
  arrival_time 3905.4227411744637
  lifetime 602.956645017761
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 11
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 50
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 27
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 42
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 11
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 27
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 18
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 2
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 0
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 2
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 29
    rom 9
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 22
    rom 40
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 41
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 2
  ]
  edge [
    source 11
    target 12
    bw 36
  ]
]
