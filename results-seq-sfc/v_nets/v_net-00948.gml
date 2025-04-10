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
  id 948
  arrival_time 20276.035077630946
  lifetime 945.1656204983825
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 13
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 9
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 26
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 1
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 17
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 4
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 17
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 24
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 41
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 30
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 0
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 29
    rom 22
  ]
  node [
    id 12
    label "12"
    cpu 29
    gpu 4
    rom 48
  ]
  node [
    id 13
    label "13"
    cpu 26
    gpu 8
    rom 18
  ]
  node [
    id 14
    label "14"
    cpu 12
    gpu 25
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
  edge [
    source 11
    target 12
    bw 9
  ]
  edge [
    source 12
    target 13
    bw 21
  ]
  edge [
    source 13
    target 14
    bw 49
  ]
]
