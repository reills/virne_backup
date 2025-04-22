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
  id 208
  arrival_time 3663.9157753483387
  lifetime 358.1381927162428
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 45
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 28
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 33
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 26
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 41
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 40
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 4
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 34
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 47
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 37
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 7
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
]
