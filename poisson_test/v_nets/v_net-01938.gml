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
  id 1938
  arrival_time 42668.37263361053
  lifetime 3027.442057275573
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 11
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 33
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 21
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 30
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 40
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 39
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 18
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 3
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 34
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 35
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 30
    rom 40
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 34
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
  edge [
    source 10
    target 11
    bw 39
  ]
]
