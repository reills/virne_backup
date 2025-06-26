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
  id 424
  arrival_time 8301.556513876334
  lifetime 865.3723851827212
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 19
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 12
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 9
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 14
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 5
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 28
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 47
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 44
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 30
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 0
    gpu 49
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 39
    gpu 9
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 29
    gpu 31
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 50
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
]
