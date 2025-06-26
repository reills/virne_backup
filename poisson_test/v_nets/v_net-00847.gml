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
  id 847
  arrival_time 17556.98503893336
  lifetime 43.015913715288896
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 22
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 38
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 42
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 21
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 24
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 40
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 9
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 29
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 26
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 40
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 37
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 10
  ]
]
