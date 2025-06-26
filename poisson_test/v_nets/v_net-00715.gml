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
  id 715
  arrival_time 14903.436113148626
  lifetime 924.4541678455462
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 20
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 10
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 30
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 3
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 35
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 41
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 37
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 42
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 30
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 25
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
]
