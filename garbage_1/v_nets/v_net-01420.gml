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
  id 1420
  arrival_time 29668.088767765053
  lifetime 398.33640260107177
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 43
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 31
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 12
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 43
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 18
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 29
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 16
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 46
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 23
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 21
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 5
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
]
