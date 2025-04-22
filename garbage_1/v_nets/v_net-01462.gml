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
  id 1462
  arrival_time 30675.347861961352
  lifetime 1280.01138156666
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 46
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 38
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 21
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 11
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 30
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 35
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 24
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 11
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 37
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 31
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 42
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 15
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
]
