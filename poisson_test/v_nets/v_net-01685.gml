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
  id 1685
  arrival_time 37575.74489762882
  lifetime 1466.4975121881578
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 12
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 14
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 25
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 29
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 31
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 46
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 47
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 14
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 4
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 7
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 22
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 20
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 14
    gpu 29
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 37
  ]
]
