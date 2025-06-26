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
  id 1403
  arrival_time 29439.632634714297
  lifetime 4423.743292105265
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 25
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 30
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 22
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 21
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 23
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 41
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 3
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 12
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 49
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 0
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 45
    rom 48
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 11
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
]
