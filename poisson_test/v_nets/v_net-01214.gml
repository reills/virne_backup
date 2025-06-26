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
  id 1214
  arrival_time 25262.041231381845
  lifetime 405.62017853613037
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 29
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 35
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 46
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 37
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 33
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 47
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 21
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 24
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 40
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 45
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 34
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
]
