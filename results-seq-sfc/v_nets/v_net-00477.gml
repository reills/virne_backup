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
  id 477
  arrival_time 8858.620047331422
  lifetime 456.6271059530275
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 22
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 37
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 18
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 42
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 28
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 33
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 2
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 48
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 21
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 17
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 22
    rom 33
  ]
  node [
    id 11
    label "11"
    cpu 46
    gpu 25
    rom 31
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 34
    rom 36
  ]
  node [
    id 13
    label "13"
    cpu 38
    gpu 23
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
  edge [
    source 11
    target 12
    bw 23
  ]
  edge [
    source 12
    target 13
    bw 5
  ]
]
