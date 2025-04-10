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
  id 998
  arrival_time 21304.55195422744
  lifetime 3181.645920903984
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 24
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 36
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 20
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 30
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 6
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 8
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 45
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 49
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 38
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 45
    rom 1
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 34
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
]
