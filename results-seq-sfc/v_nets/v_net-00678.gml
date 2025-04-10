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
  id 678
  arrival_time 14379.091033339415
  lifetime 13.797991532323481
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 19
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 13
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 33
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 3
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 31
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 37
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 41
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 39
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 8
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 42
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
]
