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
  id 686
  arrival_time 14553.310371239746
  lifetime 1456.6827509988887
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 4
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 33
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 26
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 16
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 12
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 35
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 1
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 20
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 9
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 8
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 22
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 22
    gpu 19
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 12
  ]
]
