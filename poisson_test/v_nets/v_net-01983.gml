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
  id 1983
  arrival_time 43350.686386850975
  lifetime 659.5025730728001
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 20
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 42
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 38
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 50
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 45
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 13
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 3
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 36
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 21
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 45
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 9
    rom 0
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 38
    rom 15
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 48
    rom 5
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 32
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 7
  ]
  edge [
    source 12
    target 13
    bw 24
  ]
]
