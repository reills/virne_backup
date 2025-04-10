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
  id 62
  arrival_time 1242.29732746007
  lifetime 1313.6130225118272
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 4
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 29
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 15
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 49
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 46
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 33
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 45
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 35
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 25
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 14
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
]
