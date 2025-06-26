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
  id 1970
  arrival_time 42984.21851644082
  lifetime 764.4715021201592
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 17
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 4
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 9
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 25
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 48
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 29
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 41
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 31
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 50
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 23
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 38
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 0
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
]
