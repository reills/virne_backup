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
  id 1707
  arrival_time 37872.75296279233
  lifetime 745.9864490164298
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 6
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 15
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 0
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 38
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 16
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 37
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 47
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 21
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 18
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 36
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 40
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 2
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 33
    gpu 40
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
]
