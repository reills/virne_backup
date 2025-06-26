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
  id 185
  arrival_time 3394.8020184696525
  lifetime 1446.8327420639316
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 20
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 42
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 14
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 50
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 50
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 28
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 28
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 14
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 38
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 37
    rom 32
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 41
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 1
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
]
