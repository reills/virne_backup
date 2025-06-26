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
  id 1711
  arrival_time 38113.79347956064
  lifetime 339.83820125329964
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 21
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 38
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 23
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 2
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 26
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 26
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 17
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 6
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 36
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 18
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 27
    rom 44
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 15
    rom 5
  ]
  node [
    id 12
    label "12"
    cpu 33
    gpu 30
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
]
