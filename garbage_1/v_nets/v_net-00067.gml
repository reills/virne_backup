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
  id 67
  arrival_time 1272.98599484477
  lifetime 183.31896718323225
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 35
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 48
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 19
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 44
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 48
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 31
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 27
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 18
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 30
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 13
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 33
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 28
    rom 2
  ]
  node [
    id 12
    label "12"
    cpu 18
    gpu 35
    rom 2
  ]
  node [
    id 13
    label "13"
    cpu 44
    gpu 29
    rom 45
  ]
  node [
    id 14
    label "14"
    cpu 46
    gpu 14
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
  edge [
    source 11
    target 12
    bw 11
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
  edge [
    source 13
    target 14
    bw 19
  ]
]
