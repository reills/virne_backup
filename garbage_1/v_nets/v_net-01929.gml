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
  id 1929
  arrival_time 42222.14792519948
  lifetime 2947.9674434987905
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 23
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 17
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 27
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 6
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 45
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 5
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 1
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 1
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 31
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 22
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 9
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 0
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 7
    rom 39
  ]
  node [
    id 13
    label "13"
    cpu 29
    gpu 13
    rom 12
  ]
  node [
    id 14
    label "14"
    cpu 12
    gpu 39
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 3
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 20
  ]
  edge [
    source 13
    target 14
    bw 7
  ]
]
